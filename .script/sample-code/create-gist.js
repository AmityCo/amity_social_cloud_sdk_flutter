const { Octokit } = require("@octokit/core")

async function createGist(accessToken) {
	const octokit = new Octokit({
		auth: accessToken
	})

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

module.exports = { createGist }