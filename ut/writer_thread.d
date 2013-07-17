module ut.writer_thread;

import std.concurrency;
import std.stdio;

void writeInThread() {
    auto done = false;
    Tid tid;

    while(!done) {
        string output;
        receive(
            (string msg) {
                output ~= msg;
            },
            (Tid i) {
                done = true;
                tid = i;
            },
            (OwnerTerminated trm) {
                done = true;
            }
        );
        write(output);
    }
    stdout.flush();
    if(tid != Tid.init) tid.send(thisTid);
}
