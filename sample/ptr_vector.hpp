
#pragma once

#include <memory>

class ptr_vector_base {
    struct impl; // does not depend on T
//    std::unique_ptr<impl> pImpl;
    struct impl_deleter { void operator()(impl*) const; }; // does not depend on T
    std::unique_ptr<impl, impl_deleter> pImpl;
 protected:
    void push_back_fwd(void*);
    // see implementation section for special member functions
    explicit ptr_vector_base();
    virtual ~ptr_vector_base() = default;
    ptr_vector_base(ptr_vector_base&&) = default;             // no need to define this in file.cc
    ptr_vector_base&operator=(ptr_vector_base&&) = default;   // no need to define this in file.cc
};

template<class T>
class ptr_vector : private ptr_vector_base {
public:
    void push_back(T* p) { push_back_fwd(p); }
};
