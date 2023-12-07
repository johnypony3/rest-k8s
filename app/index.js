var express = require("express");
var app = express();

app.listen(3000, () => {
    console.log("Server running on port 3000");
});

app.get("/info", (req, res, next) => {
    res.json([{
        version: process.env.npm_package_version,
        app_env: process.env.ENVIRONMENT,
        timestamp: Date.now()
    }]);
});

app.get("/", (req, res, next) => {
    res.json([{
        message: 'Automate all the things!',
        timestamp: Date.now()
    }]);
});
