
#include <unistd.h>

#include <google/protobuf/util/message_differencer.h>

#include "search.pb.h"


int main(int argc, char *argv[]) {
    // Verify that the version of the library that we linked against is
    // compatible with the version of the headers we compiled against.
    GOOGLE_PROTOBUF_VERIFY_VERSION;
  
    ::sample::request::Search orig_search;
    
    orig_search.mutable_simple()->set_s("simple.s");
    orig_search.mutable_header()->set_seq(123);
    orig_search.mutable_header()->mutable_stamp()->set_seconds(45678);
    orig_search.mutable_header()->mutable_stamp()->set_nanos(0001);

    orig_search.set_query("query");
    orig_search.set_page_number(2);
    orig_search.set_result_per_page(4);
    
    std::string buffer;
    
    orig_search.SerializeToString(&buffer);
    
    ::sample::request::Search comp_search;
    
    comp_search.ParseFromString(buffer);
    
    bool ok=::google::protobuf::util::MessageDifferencer::Equals(orig_search, comp_search);
    if(!ok)
        std::cerr << "Input and output mismatch!" << std::endl;
    else
        std::cerr << "Input and output match!" << std::endl;
        
    // Optional:  Delete all global objects allocated by libprotobuf.
    google::protobuf::ShutdownProtobufLibrary();
    return 0;
}
