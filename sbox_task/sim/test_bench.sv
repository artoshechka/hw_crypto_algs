`timescale 1ns / 1ns

module test_bench_xps;
  logic [3:0] data_;
  logic [3:0] key_;
  logic [3:0] cipherText_;
  logic [3:0] pSTable_[16];
  logic [3:0] resAssert;

  initial begin
    pSTable_[4'h0] = 4'hB;
    pSTable_[4'h1] = 4'hA;
    pSTable_[4'h2] = 4'h9;
    pSTable_[4'h3] = 4'h7;
    pSTable_[4'h4] = 4'h6;
    pSTable_[4'h5] = 4'h0;
    pSTable_[4'h6] = 4'h2;
    pSTable_[4'h7] = 4'hE;
    pSTable_[4'h8] = 4'h5;
    pSTable_[4'h9] = 4'hC;
    pSTable_[4'hA] = 4'hF;
    pSTable_[4'hB] = 4'hD;
    pSTable_[4'hC] = 4'h8;
    pSTable_[4'hD] = 4'h3;
    pSTable_[4'hE] = 4'h4;
    pSTable_[4'hF] = 4'h1;
  end

  initial begin
    $dumpfile("work/wave.ocd");
    $dumpvars(0, test_bench_xps);
  end

  initial begin
    for (int i = 0; i < 256; i++) begin
      {data_, key_} = i;
      #1;
      resAssert = pSTable_[data_] ^ key_;
      assert (cipherText_ == resAssert)
      else
        $error(
            $sformatf(
                "Wrong result_ for data_ = %h, key_ = %h: expected - %h, rtl - %h",
                data_,
                key_,
                resAssert,
                cipherText_
            )
        );
    end

    $finish;
  end

  XPSComposition dut (
      .data_(data_),
      .key_(key_),
      .cipherText_(cipherText_)
  );

endmodule
