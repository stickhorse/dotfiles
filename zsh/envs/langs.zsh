typeset -gA ENV_LANGS
ENV_LANGS=(rb red lua cyan py yellow nod red)
function {
  local lang
  local funs
  local shlist
  for lang in ${(k)ENV_LANGS}; do
    if [[ -x "$HOME/.${lang}env/bin/${lang}env" ]]; then
      path[1,0]=(~/.${lang}env/bin ~/.${lang}env/shims)
      export ${(U)lang}ENV_SHELL=zsh
      source ~/.${lang}env/completions/${lang}env.zsh
      if [[ -o interactive ]]; then
        shlist=(~/.${lang}env/libexec/${lang}env-sh-*(:t) ~/.${lang}env/plugins/*/bin/${lang}env-sh-*(:t))
        funs="
        function ${lang}env() {
          local cmd=\"\$1\"
          if [ \"\$#\" -gt 0 ]; then
            shift
          fi
          case \"\$cmd\" in
            ${(j:|:)shlist//${lang}env-sh-})
              eval \"\$(${lang}env sh-\$cmd \"\$@\")\"
            ;;
            *)
              command ${lang}env \"\$cmd\" \"\$@\"
            ;;
          esac
        }
        function __${lang}env_manpath() {
          local cur=\$(${lang}env version-name)
          if [[ "\$cur" != "\$__cur_${lang}env_version" ]]; then
            local mpath
            for mpath (~/.${lang}env/versions/*(/)) manpath=(\"\${(@)manpath:#\$mpath/share/man}\")
            manpath[1,0]=(\"$HOME/.${lang}env/versions/\$cur/share/man\"(/))
          fi
          __cur_${lang}env_version=\$cur
        }"
        eval "$funs"
        precmd_functions+=(__${lang}env_manpath)
      fi
    fi
  done
}
