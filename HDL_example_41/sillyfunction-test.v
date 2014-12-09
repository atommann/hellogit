module test;

    reg a;
    reg b;
    reg c;
    wire y;

    sillyfunction sf1(.a(a), .b(b), .c(c), .y(y));

    initial begin
        $dumpfile("sillyfunction-dump.vcd");
        $dumpvars(0, test);
        a = 0;
        b = 0;
        c = 0;
    #10 a = 0;
        b = 0;
        c = 1;
    #10 a = 0;
        b = 1;
        c = 0;
    #10 a = 0;
        b = 1;
        c = 1;
    #10 a = 1;
        b = 0;
        c = 0;
    #10 a = 1;
        b = 0;
        c = 1;
    #10 a = 1;
        b = 1;
        c = 0;
    #10 a = 1;
        b = 1;
        c = 1;
    #10 $finish;
    end
endmodule
