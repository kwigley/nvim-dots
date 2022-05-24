return {
  setup = function(client) -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.document_highlight then
      require("illuminate").on_attach(client)
    end
  end,
}
