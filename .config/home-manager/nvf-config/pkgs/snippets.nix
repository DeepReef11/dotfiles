{ vimUtils, vimPlugins }:
vimUtils.buildVimPlugin {
  name = "lilleaila-snippets";
  src = ../config/snippets;
  dependencies = with vimPlugins; [
    luasnip
    nvim-treesitter
  ];
}
