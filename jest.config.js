module.exports = {
  transform: {
    "^.+\\.jsx?$": "babel-jest",
  },
  testEnvironment: "jsdom",
  setupFilesAfterEnv: ["<rootDir>/src/setupTests.js"],
  // Necesario para las pruebas con React
};
