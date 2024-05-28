vim.keymap.set(
  "i",
  ";l",
  [[
function l(...$data)
{
    $json = json_encode($data);
    add_action('shutdown', function () use ($json) {
        echo "<script>console.log({$json})</script>";
    });
}
]],
  { noremap = true, silent = true, buffer = true, desc = "[wordpress] Create func to log to console" }
)
vim.keymap.set(
  "i",
  ";p",
  "l()<Esc>i",
  { noremap = true, silent = true, buffer = true, desc = "[wordpress] Print using the log function" }
)
