if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

" Read the python syntax to start with
if version < 600
    so <sfile>:p:h/python.vim
else
    runtime! syntax/python.vim
    unlet b:current_syntax
endif

syn case match

" Sorted by alphabet order
syn keyword buckTarget cxx_binary cxx_library cxx_genrule cxx_precompiled_header cxx_test prebuilt_cxx_library prebuilt_cxx_library_group
syn keyword buckTarget rust_binary rust_library rust_test prebuilt_rust_library

" Sorted by alphabet order
syn keyword buckArg name srcs platform_srcs headers platform_headers header_namespace 
syn keyword buckArg preprocessor_flags platform_preprocessor_flags compiler_flags platform_compiler_flags linker_extra_outputs linker_flags platform_linker_flags precompiled_header link_style 
syn keyword buckArg tests extra_xcode_sources extra_xcode_files raw_headers include_directories visibility licenses labels
syn keyword buckArg deps_query deps attrfilter except intersect filter kind set union exported_deps reexport_all_header_dependencies
syn keyword buckArg header_only header_dirs platform_header_dirs static_lib platform_static_lib static_pic_lib platform_static_pic_lib shared_lib platform_shared_lib supported_platforms_regex exported_headers
syn keyword buckArg exported_platform_headers 

if version >= 508 || !exists("did_buck_syn_inits")
    if version < 508
        let did_buck_syn_inits = 1
        command! -nargs=+ HiLink hi link <args>
    else
        command! -nargs=+ HiLink hi def link <args>
    endif

    HiLink buckTarget   Function
    HiLink buckArg      Special
    delcommand HiLink
endif

let b:current_syntax = "buck"
