# Fish shell on vi mode
function fish_user_key_bindings

  # 修复 vi 模式下自动补全快捷键 control + f 不能用
  for mode in insert default visual
      bind -M $mode \cf forward-char
  end

  fish_vi_key_bindings
end
