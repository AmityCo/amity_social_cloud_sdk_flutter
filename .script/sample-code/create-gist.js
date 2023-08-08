const { Octokit } = require("@octokit/core")
const core = require('@actions/core');

const octokit = new Octokit({
	auth: process.argv[3]
})

var msgNotice = ""
var msgEkoChat = ""

async function main() {
	var total = process.argv[2];

	for(var i = 1; i <= total; i++){
		var gistId = await createGist(i)

		msgNotice += gistId
		msgEkoChat += `:memo: Gist ID: ${gistId}#:pointing_right: Link: https://gist.github.com/${gistId}#`

		if ( i != total ) {
			msgNotice += ", "
			msgEkoChat += "#"
		}
	}

	console.log(msgNotice)
  	core.setOutput("message_notice", msgNotice)
	core.setOutput("message_chat", msgEkoChat)
}

async function createGist() {
	const lines = [
		'This is a placeholder file.',
		'',
		'This file will be automatically deleted, once you update this gist via the automated script (update-sample-code.js).'
	]
	const res = await octokit.request('POST /gists', {
		description: 'ASC Sample Code',
		public: false,
		files: {
			'placeholder_file.txt': {
				content: lines.join('\n')
			}
		}
	})

	console.log(`gist_id: ${res.data.id}`)
	console.log(`url: ${res.data.html_url}`)

	return res.data.id
}

main()
