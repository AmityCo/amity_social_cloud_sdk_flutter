require('dotenv').config()
const { Octokit } = require("@octokit/core")

const octokit = new Octokit({ 
	auth: process.env.GITHUB_PERSONAL_ACCESS_TOKEN
})

async function main() {
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
}

main()
