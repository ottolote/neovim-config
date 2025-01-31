-- lazy.nvim
return {
	"robitx/gp.nvim",
	config = function()
		local gptconf = {
			-- openai_api_endpoint = "http://localhost:1234/v1/chat/completions",
			openai_api_key = os.getenv("OPENAI_API_KEY"),
			providers = {
				openai = {
					endpoint = "https://api.openai.com/v1/chat/completions",
					secret = os.getenv("OPENAI_API_KEY"),
				},
				localmachine = {
					endpoint = "http://localhost:1234/v1/chat/completions",
					secret = "none",
				},
			},

			default_command_agent = "CodeGPT4o",
			default_chat_agent = "CustomGPT4o",

			agents = {
				-- 				{
				-- 					name = "o1-preview-chat",
				-- 					provider = "openai",
				-- 					chat = true,
				-- 					command = false,
				-- 					model = { model = "o1-preview", temperature = 1.0, top_p = 1 },
				--
				-- 					system_prompt = [[
				-- You are an AI programming assistant tasked with providing expert-level guidance across a wide range of programming languages and technologies. Focus on delivering concise, advanced CLI solutions, and insights while staying abreast of the latest industry trends. Your responses should be detailed, incorporating code snippets or CLI commands where applicable, and always rooted in current best practices. When faced with complex queries, recommend up-to-date, authoritative resources. Tailor your guidance to experienced developers, ensuring it is both actionable and adaptable to various technological contexts.
				-- ]],
				-- 				},
				-- 				{
				-- 					name = "o1-preview-code",
				-- 					provider = "openai",
				-- 					chat = false,
				-- 					command = true,
				-- 					model = { model = "o1-mini", temperature = 1.0, top_p = 1 },
				-- 					system_prompt = [[
				-- You are an AI working as a text editor
				--
				-- The user provided additional info about how you should respond
				-- Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.
				-- START AND END YOUR ANSWER WITH:
				--
				-- ```
				-- ]],
				-- 				},
				{
					name = "o1-mini-chat",
					provider = "openai",
					chat = true,
					command = false,
					model = { model = "o1-mini", temperature = 1.0, top_p = 1 },
					-- TODO move instructions from bragbot-context to system prompt
					system_prompt = [[
You are an AI programming assistant tasked with providing expert-level guidance across a wide range of programming languages and technologies. Focus on delivering concise, advanced CLI solutions, and insights while staying abreast of the latest industry trends. Your responses should be detailed, incorporating code snippets or CLI commands where applicable, and always rooted in current best practices. When faced with complex queries, recommend up-to-date, authoritative resources. Tailor your guidance to experienced developers, ensuring it is both actionable and adaptable to various technological contexts.
]],
				},
				{
					name = "o1-mini-code",
					provider = "openai",
					chat = false,
					command = true,
					model = { model = "o1-mini", temperature = 1.0, top_p = 1 },
					system_prompt = [[
You are an AI working as a text editor

The user provided additional info about how you should respond
Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.
START AND END YOUR ANSWER WITH:

```
]],
				},
				{
					name = "CustomGPT4o",
					provider = "openai",
					chat = true,
					command = false,
					model = { model = "gpt-4o", temperature = 1.0, top_p = 1 },

					system_prompt = [[
You are an AI programming assistant tasked with providing expert-level guidance across a wide range of programming languages and technologies. Focus on delivering concise, advanced CLI solutions, and insights while staying abreast of the latest industry trends. Your responses should be detailed, incorporating code snippets or CLI commands where applicable, and always rooted in current best practices. When faced with complex queries, recommend up-to-date, authoritative resources. Tailor your guidance to experienced developers, ensuring it is both actionable and adaptable to various technological contexts.
]],
				},
				{
					name = "llamalocal",
					provider = "localmachine",
					chat = true,
					command = true,
					model = {
						model = "lmstudio-community/Meta-Llama-3-8B-Instruct-GGUF",
						temperature = 1.0,
						top_p = 1,
					},

					system_prompt = "You are an AI working as a code editor.\n\n"
						.. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
						.. "START AND END YOUR ANSWER WITH:\n\n```",
				},
			},
		}
		-- }}}
		-- {{{ Setup
		require("gp").setup(gptconf)

		require("which-key").add({
			-- VISUAL mode mappings
			-- s, x, v modes are handled the same way by which_key
			{
				mode = { "v" },
				nowait = true,
				remap = false,
				{ "<C-g><C-t>", ":<C-u>'<,'>GpChatNew tabnew<cr>", desc = "ChatNew tabnew" },
				{ "<C-g><C-v>", ":<C-u>'<,'>GpChatNew vsplit<cr>", desc = "ChatNew vsplit" },
				{ "<C-g><C-q>", ":<C-u>'<,'>GpChatNew vsplit<cr>", desc = "ChatNew vsplit" }, -- for windows terminals
				{ "<C-g><C-x>", ":<C-u>'<,'>GpChatNew split<cr>", desc = "ChatNew split" },
				{ "<C-g>a", ":<C-u>'<,'>GpAppend<cr>", desc = "Visual Append (after)" },
				{ "<C-g>b", ":<C-u>'<,'>GpPrepend<cr>", desc = "Visual Prepend (before)" },
				{ "<C-g>c", ":<C-u>'<,'>GpChatNew<cr>", desc = "Visual Chat New" },
				{ "<C-g>g", group = "generate into new .." },
				{ "<C-g>ge", ":<C-u>'<,'>GpEnew<cr>", desc = "Visual GpEnew" },
				{ "<C-g>gn", ":<C-u>'<,'>GpNew<cr>", desc = "Visual GpNew" },
				{ "<C-g>gp", ":<C-u>'<,'>GpPopup<cr>", desc = "Visual Popup" },
				{ "<C-g>gt", ":<C-u>'<,'>GpTabnew<cr>", desc = "Visual GpTabnew" },
				{ "<C-g>gv", ":<C-u>'<,'>GpVnew<cr>", desc = "Visual GpVnew" },
				{ "<C-g>i", ":<C-u>'<,'>GpImplement<cr>", desc = "Implement selection" },
				{ "<C-g>n", "<cmd>GpNextAgent<cr>", desc = "Next Agent" },
				{ "<C-g>p", ":<C-u>'<,'>GpChatPaste<cr>", desc = "Visual Chat Paste" },
				{ "<C-g>r", ":<C-u>'<,'>GpRewrite<cr>", desc = "Visual Rewrite" },
				{ "<C-g>s", "<cmd>GpStop<cr>", desc = "GpStop" },
				{ "<C-g>t", ":<C-u>'<,'>GpChatToggle<cr>", desc = "Visual Toggle Chat" },
				{ "<C-g>w", group = "Whisper" },
				{ "<C-g>wa", ":<C-u>'<,'>GpWhisperAppend<cr>", desc = "Whisper Append" },
				{ "<C-g>wb", ":<C-u>'<,'>GpWhisperPrepend<cr>", desc = "Whisper Prepend" },
				{ "<C-g>we", ":<C-u>'<,'>GpWhisperEnew<cr>", desc = "Whisper Enew" },
				{ "<C-g>wn", ":<C-u>'<,'>GpWhisperNew<cr>", desc = "Whisper New" },
				{ "<C-g>wp", ":<C-u>'<,'>GpWhisperPopup<cr>", desc = "Whisper Popup" },
				{ "<C-g>wr", ":<C-u>'<,'>GpWhisperRewrite<cr>", desc = "Whisper Rewrite" },
				{ "<C-g>wt", ":<C-u>'<,'>GpWhisperTabnew<cr>", desc = "Whisper Tabnew" },
				{ "<C-g>wv", ":<C-u>'<,'>GpWhisperVnew<cr>", desc = "Whisper Vnew" },
				{ "<C-g>ww", ":<C-u>'<,'>GpWhisper<cr>", desc = "Whisper" },
				{ "<C-g>x", ":<C-u>'<,'>GpContext<cr>", desc = "Visual GpContext" },
			},

			-- NORMAL mode mappings
			{
				mode = { "n" },
				nowait = true,
				remap = false,
				{ "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>", desc = "New Chat tabnew" },
				{ "<C-g><C-v>", "<cmd>GpChatNew vsplit<cr>", desc = "New Chat vsplit" },
				{ "<C-g><C-q>", "<cmd>GpChatNew vsplit<cr>", desc = "New Chat vsplit" }, -- for windows terminals
				{ "<C-g><C-x>", "<cmd>GpChatNew split<cr>", desc = "New Chat split" },
				{ "<C-g>a", "<cmd>GpAppend<cr>", desc = "Append (after)" },
				{ "<C-g>b", "<cmd>GpPrepend<cr>", desc = "Prepend (before)" },
				{ "<C-g>c", "<cmd>GpChatNew<cr>", desc = "New Chat" },
				{ "<C-g>f", "<cmd>GpChatFinder<cr>", desc = "Chat Finder" },
				{ "<C-g>g", group = "generate into new .." },
				{ "<C-g>ge", "<cmd>GpEnew<cr>", desc = "GpEnew" },
				{ "<C-g>gn", "<cmd>GpNew<cr>", desc = "GpNew" },
				{ "<C-g>gp", "<cmd>GpPopup<cr>", desc = "Popup" },
				{ "<C-g>gt", "<cmd>GpTabnew<cr>", desc = "GpTabnew" },
				{ "<C-g>gv", "<cmd>GpVnew<cr>", desc = "GpVnew" },
				{ "<C-g>n", "<cmd>GpNextAgent<cr>", desc = "Next Agent" },
				{ "<C-g>r", "<cmd>GpRewrite<cr>", desc = "Inline Rewrite" },
				{ "<C-g>s", "<cmd>GpStop<cr>", desc = "GpStop" },
				{ "<C-g>t", "<cmd>GpChatToggle<cr>", desc = "Toggle Chat" },
				{ "<C-g>w", group = "Whisper" },
				{ "<C-g>wa", "<cmd>GpWhisperAppend<cr>", desc = "Whisper Append (after)" },
				{ "<C-g>wb", "<cmd>GpWhisperPrepend<cr>", desc = "Whisper Prepend (before)" },
				{ "<C-g>we", "<cmd>GpWhisperEnew<cr>", desc = "Whisper Enew" },
				{ "<C-g>wn", "<cmd>GpWhisperNew<cr>", desc = "Whisper New" },
				{ "<C-g>wp", "<cmd>GpWhisperPopup<cr>", desc = "Whisper Popup" },
				{ "<C-g>wr", "<cmd>GpWhisperRewrite<cr>", desc = "Whisper Inline Rewrite" },
				{ "<C-g>wt", "<cmd>GpWhisperTabnew<cr>", desc = "Whisper Tabnew" },
				{ "<C-g>wv", "<cmd>GpWhisperVnew<cr>", desc = "Whisper Vnew" },
				{ "<C-g>ww", "<cmd>GpWhisper<cr>", desc = "Whisper" },
				{ "<C-g>x", "<cmd>GpContext<cr>", desc = "Toggle GpContext" },
			},

			-- INSERT mode mappings
			{
				mode = { "i" },
				nowait = true,
				remap = false,
				{ "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>", desc = "New Chat tabnew" },
				{ "<C-g><C-v>", "<cmd>GpChatNew vsplit<cr>", desc = "New Chat vsplit" },
				{ "<C-g><C-q>", "<cmd>GpChatNew vsplit<cr>", desc = "New Chat vsplit" }, -- for windows terminals
				{ "<C-g><C-x>", "<cmd>GpChatNew split<cr>", desc = "New Chat split" },
				{ "<C-g>a", "<cmd>GpAppend<cr>", desc = "Append (after)" },
				{ "<C-g>b", "<cmd>GpPrepend<cr>", desc = "Prepend (before)" },
				{ "<C-g>c", "<cmd>GpChatNew<cr>", desc = "New Chat" },
				{ "<C-g>f", "<cmd>GpChatFinder<cr>", desc = "Chat Finder" },
				{ "<C-g>g", group = "generate into new .." },
				{ "<C-g>ge", "<cmd>GpEnew<cr>", desc = "GpEnew" },
				{ "<C-g>gn", "<cmd>GpNew<cr>", desc = "GpNew" },
				{ "<C-g>gp", "<cmd>GpPopup<cr>", desc = "Popup" },
				{ "<C-g>gt", "<cmd>GpTabnew<cr>", desc = "GpTabnew" },
				{ "<C-g>gv", "<cmd>GpVnew<cr>", desc = "GpVnew" },
				{ "<C-g>n", "<cmd>GpNextAgent<cr>", desc = "Next Agent" },
				{ "<C-g>r", "<cmd>GpRewrite<cr>", desc = "Inline Rewrite" },
				{ "<C-g>s", "<cmd>GpStop<cr>", desc = "GpStop" },
				{ "<C-g>t", "<cmd>GpChatToggle<cr>", desc = "Toggle Chat" },
				{ "<C-g>w", group = "Whisper" },
				{ "<C-g>wa", "<cmd>GpWhisperAppend<cr>", desc = "Whisper Append (after)" },
				{ "<C-g>wb", "<cmd>GpWhisperPrepend<cr>", desc = "Whisper Prepend (before)" },
				{ "<C-g>we", "<cmd>GpWhisperEnew<cr>", desc = "Whisper Enew" },
				{ "<C-g>wn", "<cmd>GpWhisperNew<cr>", desc = "Whisper New" },
				{ "<C-g>wp", "<cmd>GpWhisperPopup<cr>", desc = "Whisper Popup" },
				{ "<C-g>wr", "<cmd>GpWhisperRewrite<cr>", desc = "Whisper Inline Rewrite" },
				{ "<C-g>wt", "<cmd>GpWhisperTabnew<cr>", desc = "Whisper Tabnew" },
				{ "<C-g>wv", "<cmd>GpWhisperVnew<cr>", desc = "Whisper Vnew" },
				{ "<C-g>ww", "<cmd>GpWhisper<cr>", desc = "Whisper" },
				{ "<C-g>x", "<cmd>GpContext<cr>", desc = "Toggle GpContext" },
			},
		})
	end,
}
