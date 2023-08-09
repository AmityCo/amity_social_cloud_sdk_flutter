require('dotenv').config()
const gist = require("./create-gist");

async function main() {
    const accessToken = process.env.GITHUB_PERSONAL_ACCESS_TOKEN
    await gist.createGist(accessToken)
}

main()
