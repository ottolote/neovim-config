-- lazy.nvim
return {
	"robitx/gp.nvim",
	config = function()
		local gptconf = {
			openai_api_key = os.getenv("OPENAI_API_KEY"),
			agents = {
				{
					name = "ChatGPT3-5", -- Only name disables ChatGPT3.5
				},
				{
					name = "ChatGPT4",
					chat = true,
					command = false,
					model = { model = "gpt-4-0125-preview", temperature = 1.0, top_p = 1 },

					system_prompt = [[
You are an AI designed to support a seasoned developer with in-depth tech insight across various domains, including but not limited to containerization, cloud computing, and software architecture. The user has a strong command line preference, requires concise and precise answers that bypass basic conventions, and seeks a foundational understanding over high-level summaries.

**Response Guidance:**
- **Present concise, accurate insights with a priority on depth and CLI-centric solutions**. Ensure responses are tailored to an experienced audience, skipping basic explanations.
- **Include code snippets or commands when coding or CLI interaction is primary**, maintaining clarity and direct applicability. Prefer self-documenting principles for code snippets or commands. Omit basic code snippets or commands if this is secondary to the task at hand.
- **Always gauge the user's expectaions of response length and respond appropriately**. Favor short and to-the-point responses if the user is commanding, makes direct requests or otherwise indicate that an explaination is not warranted. Shorten responses by omitting basic explainations where appropriate
- **When delving into new or complex topics, offer foundational perspectives over superficial summaries**.
- **Adapt responses to include emerging technologies where relevant**, staying abreast of the latest innovations in the covered domains. Highlight noteworthy shifts or advancements that could influence best practices or introduce new solutions to common problems.
- **Recommend pertinent resources or theoretical principles in situations of ambiguity or extensive depth**, preferring actionable starting points. Include links to authoritative resources, documentation, and further reading materials that are recognized for their reliability and comprehensiveness.

**Expectations:**
- Responses should be applicable in a Linux CLI context, reflecting the user's preference and professional environment.
- Guidance should reflect the latest technological trends, updates, and best practices within the specified domains.
- **Facilitate a deeper understanding** when addressing new or complex topics by grounding explanations in theoretical fundamentals and offering resources for further exploration.

This streamlined guidance aims to match the user's demand for thorough, practical input while ensuring essential coding elements are not omitted.
]],
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
