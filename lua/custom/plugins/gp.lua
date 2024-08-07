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

		-- shortcuts might be setup here (see Usage > Shortcuts in Readme)
		require("which-key").register({
			-- ...
			["<C-g>"] = {
				c = { ":<C-u>'<,'>GpChatNew<cr>", "Visual Chat New" },
				p = { ":<C-u>'<,'>GpChatPaste<cr>", "Visual Chat Paste" },
				t = { ":<C-u>'<,'>GpChatToggle<cr>", "Visual Toggle Chat" },

				["<C-x>"] = { ":<C-u>'<,'>GpChatNew split<cr>", "Visual Chat New split" },
				["<C-v>"] = { ":<C-u>'<,'>GpChatNew vsplit<cr>", "Visual Chat New vsplit" },
				["<C-q>"] = { ":<C-u>'<,'>GpChatNew vsplit<cr>", "Visual Chat New vsplit" }, -- for windows terminals
				["<C-t>"] = { ":<C-u>'<,'>GpChatNew tabnew<cr>", "Visual Chat New tabnew" },

				r = { ":<C-u>'<,'>GpRewrite<cr>", "Visual Rewrite" },
				a = { ":<C-u>'<,'>GpAppend<cr>", "Visual Append (after)" },
				b = { ":<C-u>'<,'>GpPrepend<cr>", "Visual Prepend (before)" },
				i = { ":<C-u>'<,'>GpImplement<cr>", "Implement selection" },

				g = {
					name = "generate into new ..",
					p = { ":<C-u>'<,'>GpPopup<cr>", "Visual Popup" },
					e = { ":<C-u>'<,'>GpEnew<cr>", "Visual GpEnew" },
					n = { ":<C-u>'<,'>GpNew<cr>", "Visual GpNew" },
					v = { ":<C-u>'<,'>GpVnew<cr>", "Visual GpVnew" },
					t = { ":<C-u>'<,'>GpTabnew<cr>", "Visual GpTabnew" },
				},

				n = { "<cmd>GpNextAgent<cr>", "Next Agent" },
				s = { "<cmd>GpStop<cr>", "GpStop" },
				x = { ":<C-u>'<,'>GpContext<cr>", "Visual GpContext" },

				w = {
					name = "Whisper",
					w = { ":<C-u>'<,'>GpWhisper<cr>", "Whisper" },
					r = { ":<C-u>'<,'>GpWhisperRewrite<cr>", "Whisper Rewrite" },
					a = { ":<C-u>'<,'>GpWhisperAppend<cr>", "Whisper Append (after)" },
					b = { ":<C-u>'<,'>GpWhisperPrepend<cr>", "Whisper Prepend (before)" },
					p = { ":<C-u>'<,'>GpWhisperPopup<cr>", "Whisper Popup" },
					e = { ":<C-u>'<,'>GpWhisperEnew<cr>", "Whisper Enew" },
					n = { ":<C-u>'<,'>GpWhisperNew<cr>", "Whisper New" },
					v = { ":<C-u>'<,'>GpWhisperVnew<cr>", "Whisper Vnew" },
					t = { ":<C-u>'<,'>GpWhisperTabnew<cr>", "Whisper Tabnew" },
				},
			},
			-- ...
		}, {
			mode = "v", -- VISUAL mode
			prefix = "",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = true,
		})

		-- NORMAL mode mappings
		require("which-key").register({
			-- ...
			["<C-g>"] = {
				c = { "<cmd>GpChatNew<cr>", "New Chat" },
				t = { "<cmd>GpChatToggle<cr>", "Toggle Chat" },
				f = { "<cmd>GpChatFinder<cr>", "Chat Finder" },

				["<C-x>"] = { "<cmd>GpChatNew split<cr>", "New Chat split" },
				["<C-v>"] = { "<cmd>GpChatNew vsplit<cr>", "New Chat vsplit" },
				["<C-q>"] = { "<cmd>GpChatNew vsplit<cr>", "New Chat vsplit" }, -- for windows terminals
				["<C-t>"] = { "<cmd>GpChatNew tabnew<cr>", "New Chat tabnew" },

				r = { "<cmd>GpRewrite<cr>", "Inline Rewrite" },
				a = { "<cmd>GpAppend<cr>", "Append (after)" },
				b = { "<cmd>GpPrepend<cr>", "Prepend (before)" },

				g = {
					name = "generate into new ..",
					p = { "<cmd>GpPopup<cr>", "Popup" },
					e = { "<cmd>GpEnew<cr>", "GpEnew" },
					n = { "<cmd>GpNew<cr>", "GpNew" },
					v = { "<cmd>GpVnew<cr>", "GpVnew" },
					t = { "<cmd>GpTabnew<cr>", "GpTabnew" },
				},

				n = { "<cmd>GpNextAgent<cr>", "Next Agent" },
				s = { "<cmd>GpStop<cr>", "GpStop" },
				x = { "<cmd>GpContext<cr>", "Toggle GpContext" },

				w = {
					name = "Whisper",
					w = { "<cmd>GpWhisper<cr>", "Whisper" },
					r = { "<cmd>GpWhisperRewrite<cr>", "Whisper Inline Rewrite" },
					a = { "<cmd>GpWhisperAppend<cr>", "Whisper Append (after)" },
					b = { "<cmd>GpWhisperPrepend<cr>", "Whisper Prepend (before)" },
					p = { "<cmd>GpWhisperPopup<cr>", "Whisper Popup" },
					e = { "<cmd>GpWhisperEnew<cr>", "Whisper Enew" },
					n = { "<cmd>GpWhisperNew<cr>", "Whisper New" },
					v = { "<cmd>GpWhisperVnew<cr>", "Whisper Vnew" },
					t = { "<cmd>GpWhisperTabnew<cr>", "Whisper Tabnew" },
				},
			},
			-- ...
		}, {
			mode = "n", -- NORMAL mode
			prefix = "",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = true,
		})

		-- INSERT mode mappings
		require("which-key").register({
			-- ...
			["<C-g>"] = {
				c = { "<cmd>GpChatNew<cr>", "New Chat" },
				t = { "<cmd>GpChatToggle<cr>", "Toggle Chat" },
				f = { "<cmd>GpChatFinder<cr>", "Chat Finder" },

				["<C-x>"] = { "<cmd>GpChatNew split<cr>", "New Chat split" },
				["<C-v>"] = { "<cmd>GpChatNew vsplit<cr>", "New Chat vsplit" },
				["<C-q>"] = { "<cmd>GpChatNew vsplit<cr>", "New Chat vsplit" }, -- for windows terminals
				["<C-t>"] = { "<cmd>GpChatNew tabnew<cr>", "New Chat tabnew" },

				r = { "<cmd>GpRewrite<cr>", "Inline Rewrite" },
				a = { "<cmd>GpAppend<cr>", "Append (after)" },
				b = { "<cmd>GpPrepend<cr>", "Prepend (before)" },

				g = {
					name = "generate into new ..",
					p = { "<cmd>GpPopup<cr>", "Popup" },
					e = { "<cmd>GpEnew<cr>", "GpEnew" },
					n = { "<cmd>GpNew<cr>", "GpNew" },
					v = { "<cmd>GpVnew<cr>", "GpVnew" },
					t = { "<cmd>GpTabnew<cr>", "GpTabnew" },
				},

				x = { "<cmd>GpContext<cr>", "Toggle GpContext" },
				s = { "<cmd>GpStop<cr>", "GpStop" },
				n = { "<cmd>GpNextAgent<cr>", "Next Agent" },

				w = {
					name = "Whisper",
					w = { "<cmd>GpWhisper<cr>", "Whisper" },
					r = { "<cmd>GpWhisperRewrite<cr>", "Whisper Inline Rewrite" },
					a = { "<cmd>GpWhisperAppend<cr>", "Whisper Append (after)" },
					b = { "<cmd>GpWhisperPrepend<cr>", "Whisper Prepend (before)" },
					p = { "<cmd>GpWhisperPopup<cr>", "Whisper Popup" },
					e = { "<cmd>GpWhisperEnew<cr>", "Whisper Enew" },
					n = { "<cmd>GpWhisperNew<cr>", "Whisper New" },
					v = { "<cmd>GpWhisperVnew<cr>", "Whisper Vnew" },
					t = { "<cmd>GpWhisperTabnew<cr>", "Whisper Tabnew" },
				},
			},
			-- ...
		}, {
			mode = "i", -- INSERT mode
			prefix = "",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = true,
		})
	end,
}
