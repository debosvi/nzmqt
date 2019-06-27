
#include "ptr_vector.hpp"

struct ptr_vector_base::impl {
    void **beg, **end, **cap;
    void push_back(void* p) {
        if (end == cap) reallocate(end - beg + 1);
        *end++ = p;
    }
    void reallocate(size_t sz) {  }
};

void ptr_vector_base::impl_deleter::operator()(ptr_vector_base::impl* ptr) const { /* delete ptr; */ }

void ptr_vector_base::push_back_fwd(void* p) { pImpl->push_back(p); }

ptr_vector_base::ptr_vector_base() : pImpl(new impl) {}


