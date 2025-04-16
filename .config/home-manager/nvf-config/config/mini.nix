{
  util,
  lib,
  colorScheme',
  ...
}:
{
#   vim = {
#     mini = {
#       # Individual mini plugins
#       align.enable = true;
#       ai.enable = true;
#       files = {
#         enable = true;
#         # Custom keymaps for files will be handled separately
#       };
#       move.enable = true;
#       splitjoin.enable = true;
#       surround = {
#         enable = true;
#         setupOpts.mappings = {
#           add = "gsa";
#           delete = "gsd";
#           find = "gsf";
#           find_left = "gsF";
#           highlight = "gsh";
#           replace = "gsr";
#           update_n_lines = "gsn";
#         };
#       };
#       misc = {
#         enable = true;
#         setupOpts = lib.generators.mkLuaInline ''require("mini.misc").setup_restore_cursor()'';
#       };
#       indentscope = {
#         enable = true;
#         setupOpts = {
#           draw = {
#             delay = 0;
#             animation = lib.generators.mkLuaInline ''require("mini.indentscope").gen_animation.none()'';
#             priority = 2;
#           };
#           mappings = {
#             object_scope = "ii";
#             object_scope_with_border = "ai";
#             goto_top = "[i";
#             goto_bottom = "]i";
#           };
#           options = {
#             border = "both";
#             indent_at_cursor = false;
#             try_as_border = false;
#           };
#           symbol = "╎";
#         };
#       };
#       animate = {
#         enable = true;
#         setupOpts = {
#           scroll.enable = false;
#           cursor = {
#             enable = true;
#             timing = lib.generators.mkLuaInline ''
#               require('mini.animate').gen_timing.cubic({
#                 easing = "out",
#                 duration = 400,
#                 unit = "total"
#               })
#             '';
#           };
#         };
#       };
#     };
#
#     keymaps = [
#       (util.mkKeymap "n" "<leader>e" "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>" "Open minifiles at buffer location")
#       (util.mkKeymap "n" "<leader>E" "<cmd>lua MiniFiles.open()<cr>" "Open minifiles at cwd")
#       (util.mkKeymap "n" "<M-Up>" "<cmd>lua MiniMove.move_line('up')<cr>" "MiniMove line")
#       (util.mkKeymap "n" "<M-Down>" "<cmd>lua MiniMove.move_line('down')<cr>" "MiniMove line")
#       (util.mkKeymap "n" "<M-Left>" "<cmd>lua MiniMove.move_line('left')<cr>" "MiniMove line")
#       (util.mkKeymap "n" "<M-Right>" "<cmd>lua MiniMove.move_line('right')<cr>" "MiniMove line")
#       (util.mkKeymap "x" "<M-Up>" "<cmd>lua MiniMove.move_selection('up')<cr>" "MiniMove selection")
#       (util.mkKeymap "x" "<M-Down>" "<cmd>lua MiniMove.move_selection('down')<cr>" "MiniMove selection")
#       (util.mkKeymap "x" "<M-Left>" "<cmd>lua MiniMove.move_selection('left')<cr>" "MiniMove selection")
#       (util.mkKeymap "x" "<M-Right>" "<cmd>lua MiniMove.move_selection('right')<cr>" "MiniMove selection")
#     ];
#
#     autoGroups = {
#       mini_files_mappings = {
#         clear = true;
#         events = ["User"];
#         patterns = ["MiniFilesBufferCreate"];
#         callback = lib.generators.mkLuaInline ''
#           function(args)
#             local map_buf = function(lhs, rhs)
#               vim.keymap.set("n", lhs, rhs, { buffer = args.data.buf_id })
#             end
#
#             local go_in_plus = function()
#               for _ = 1, vim.v.count1 do
#                 MiniFiles.go_in({ close_on_file = true })
#               end
#             end
#
#             map_buf("<CR>", go_in_plus)
#             map_buf("<Right>", go_in_plus)
#             map_buf("<BS>", MiniFiles.go_out)
#             map_buf("<Left>", MiniFiles.go_out)
#             map_buf("<Esc>", MiniFiles.close)
#           end
#         '';
#       };
#     };
#   };
}
