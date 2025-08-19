local M = {}

local util = require("module.util")

local cpp_sample = [[
#include <iostream>
#include <vector>
#include <algorithm>

int main() {
    std::vector<int> nums = {1, 2, 3, 4, 5};
    std::for_each(nums.begin(), nums.end(), [](int x){
        std::cout << x << std::endl;
    });
    return 0;
}
]]

function M.choose_colorscheme_with_cpp_preview()
  local schemes = util.get_colorscheme_files()
  require('fzf-lua').colorschemes({
    prompt = "Local Colorscheme> ",
    colors = schemes,
  })
end

return M
