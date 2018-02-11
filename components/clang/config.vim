if g:MAC 
    let g:deoplete#sources#clang#flags = ['-I/usr/include', '-I/usr/include/c++/4.2.1', '-I/usr/local/opt/llvm/lib/clang/5.0.1/include']
endif
if g:LINUX
    let g:deoplete#sources#clang#flags = ['-I/usr/include', '-I/usr/include/c++/7.2.0', '-I/usr/include/clang/4.0.1/include']
endif
let g:deoplete#sources#clang#executable = "/usr/bin/clang"
let g:deoplete#sources#clang#autofill_neomake = 1
let g:neomake_c_enabled_makers = ['clang']
let g:neomake_cpp_enabled_makers = ['clang']
let g:deoplete#sources#clang#std={'c': 'c11', 'cpp': 'c++1z', 'objc': 'c11', 'objcpp': 'c++1z'}