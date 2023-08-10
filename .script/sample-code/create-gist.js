require('dotenv').config()
const { Octokit } = require("@octokit/core")

async function createGist() {
	validateENV()

	const octokit = new Octokit({
		auth: process.env.GH_PERSONAL_ACCESS_TOKEN
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

function validateENV() {

	const expectedKeys = [
		// The personal access token of that user; used for authenticate.
		'GH_PERSONAL_ACCESS_TOKEN'
	]

	for (const key of expectedKeys) {
		if (!process.env.hasOwnProperty(key)) {
			console.error(`unable to find env.${key}.
- If you run this script on your local machine, plase make sure to create '.env' file from '.env_template'
- If you run this script on CI/CD, please make sure to inject env variables properly.
- The value of each key; can be asked from the admin of dynamic sample code feature.
`)
			throw `env does not contain ${key}`
		}
	}
}

if (require.main === module){
	createGist()
} else {
	module.exports = { createGist }
}