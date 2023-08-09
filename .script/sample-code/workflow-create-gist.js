const core = require('@actions/core');
const gist = require("./create-gist");

async function main() {
	const total = parseInt(process.argv[2])
	const accessToken = process.argv[3]

	let msgNotice = ""
	let msgEkoChat = ""

	for(let i = 1; i <= total; i++) {
		const gistId = await gist.createGist(accessToken)

		msgNotice += gistId
		msgEkoChat += `:memo: Gist ID: ${gistId}#:pointing_right: Link: https://gist.github.com/${gistId}#`

		if ( i < total ) {
			msgNotice += ", "
			msgEkoChat += "#"
		}
	}

  	core.setOutput("message_notice", msgNotice)
	core.setOutput("message_chat", msgEkoChat)
}

main()