require("null-ls").setup({
	sources = {
    require("null-ls").builtins.formatting.stylua.with({
      extra_args = {
        "--indent-type",
        "Spaces",
        "--indent-width",
        "2",
      },
    }),
		require("null-ls").builtins.formatting.prettier.with({ extra_args = { "--single-quote", "--jsx-single-quote" }}),
		require("null-ls").builtins.formatting.google_java_format
	},
})
