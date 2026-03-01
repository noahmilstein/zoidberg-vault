#!/usr/bin/env python3
import json
import os
import threading
import time
import urllib.request
from http.server import BaseHTTPRequestHandler, HTTPServer

CAA_API_KEY = os.environ.get("CAA_API_KEY", "")


def post_json(url: str, payload: dict, token: str):
    data = json.dumps(payload).encode("utf-8")
    req = urllib.request.Request(url, data=data, method="POST")
    req.add_header("Content-Type", "application/json")
    if token:
      req.add_header("Authorization", f"Bearer {token}")
    with urllib.request.urlopen(req, timeout=15) as r:
        return r.status, r.read().decode("utf-8", errors="ignore")


class Handler(BaseHTTPRequestHandler):
    def _send(self, code: int, payload: dict):
        body = json.dumps(payload).encode("utf-8")
        self.send_response(code)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def do_POST(self):
        if self.path != "/hooks/caa-dispatch":
            self._send(404, {"ok": False, "error": "not_found"})
            return
        length = int(self.headers.get("Content-Length", "0"))
        raw = self.rfile.read(length)
        try:
            body = json.loads(raw.decode("utf-8"))
        except Exception:
            self._send(400, {"ok": False, "error": "invalid_json"})
            return

        task = (body or {}).get("task", {})
        dispatch = (body or {}).get("dispatch", {})
        task_id = task.get("id")
        idem = dispatch.get("idempotencyKey")
        cb = dispatch.get("callbackUrl")

        if not task_id or not idem or not cb:
            self._send(400, {"ok": False, "error": "missing_required_fields"})
            return

        def worker():
            ts = int(time.time())
            # running
            post_json(cb, {
                "taskId": task_id,
                "idempotencyKey": idem,
                "updateKey": f"{idem}:running:{ts}",
                "status": "running",
                "message": "Autonomous dispatch receiver accepted task and started execution."
            }, CAA_API_KEY)
            time.sleep(2)
            # blocked terminal for safe deterministic proof until real executor is wired
            post_json(cb, {
                "taskId": task_id,
                "idempotencyKey": idem,
                "updateKey": f"{idem}:blocked:{ts}",
                "status": "blocked",
                "blockedReason": "DISPATCH_RECEIVER_STUB: receiver reachable; execution worker not wired yet."
            }, CAA_API_KEY)

        threading.Thread(target=worker, daemon=True).start()
        self._send(200, {"ok": True, "accepted": True})

    def log_message(self, fmt, *args):
        return


if __name__ == "__main__":
    port = int(os.environ.get("DISPATCH_RECEIVER_PORT", "8787"))
    httpd = HTTPServer(("0.0.0.0", port), Handler)
    print(f"dispatch receiver listening on :{port}", flush=True)
    httpd.serve_forever()
