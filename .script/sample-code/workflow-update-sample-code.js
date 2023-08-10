require('dotenv').config()
const core = require('@actions/core');
const gist = require("./update-sample-code");

async function main() {

    const changedMeta = await gist.updateSampleCode()

    let message = ""
    for (const meta of changedMeta){
        message += composeChatMessage(meta)
    }

    console.log('composing chat message...')
    core.setOutput("message_chat", message)
}

main()

function composeChatMessage(meta) {
    const gistId = meta.gist_id
    const fileName = meta.filename
    const ascPage = meta.asc_page
    const description = meta.description

    return `:new_line::memo: Gist Id: ${gistId}:new_line::file: File Name: ${fileName}:new_line::page: ASC Page: ${ascPage}:new_line::desc: Description: ${description}:new_line:`
}