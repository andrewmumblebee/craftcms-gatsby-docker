"use strict";
const { spawn } = require("child_process");

/*
 * Install dependencies every time package.json changes
 */
spawn('nodemon -w package.json --exec "yarn install"', {
  stdio: "inherit",
  shell: true,
});
