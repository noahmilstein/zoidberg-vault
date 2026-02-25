// Zoidberg Instantly Webhook (MVP)
// Created 2026-02-25

import http from "http";

const PORT = 8787;

const server = http.createServer(async (req, res) => {
  if (req.method === "POST" && req.url === "/instantly/webhook") {
    let body = "";
    req.on("data", chunk => (body += chunk));
    req.on("end", async () => {
      try {
        const event = JSON.parse(body);
        console.log("Instantly webhook received:", event.type);

        // TODO: Implement reply handling logic
        // 1. Lookup contact in Simply Sauna via API
        // 2. Set status = contacted
        // 3. Create task
        // 4. Send Slack DM

        res.writeHead(200);
        res.end("OK");
      } catch (err) {
        console.error(err);
        res.writeHead(400);
        res.end("Bad Request");
      }
    });
  } else {
    res.writeHead(404);
    res.end();
  }
});

server.listen(PORT, () => {
  console.log(`Zoidberg webhook listening on port ${PORT}`);
});
