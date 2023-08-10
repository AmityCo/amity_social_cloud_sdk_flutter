const core = require('@actions/core');
const gist = require("./create-gist");

async function main() {
    const total = parseInt(process.argv[2])

    let msgNotice = ""
    let msgEkoChat = ""

    console.log(`total: ${total}`)

    for(let i = 1; i <= total; i++) {
        const gistId = await gist.createGist()

        msgNotice += gistId
        msgEkoChat += `:memo: Gist ID: ${gistId}#:pointing_right: Link: https://gist.github.com/${gistId}#`

        if ( i < total ) {
            msgNotice += ", "
            msgEkoChat += "#"
        }
    }

    console.log(msgNotice)
    core.setOutput("message_notice", msgNotice)
    core.setOutput("message_chat", msgEkoChat)
}

main()