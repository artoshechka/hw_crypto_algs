`timescale 1ns / 1ns

module test_bench_xps;
  logic [3:0] data_;
  logic [3:0] key_;
  logic [3:0] cipherText_;
  logic [3:0] sTable_[0:15];
  logic [3:0] expectedCipherText_;

  initial begin
    sTable_[4'h0] = 4'hE;
    sTable_[4'h1] = 4'hC;
    sTable_[4'h2] = 4'h6;
    sTable_[4'h3] = 4'hB;
    sTable_[4'h4] = 4'h9;
    sTable_[4'h5] = 4'h0;
    sTable_[4'h6] = 4'h8;
    sTable_[4'h7] = 4'hD;
    sTable_[4'h8] = 4'h3;
    sTable_[4'h9] = 4'h5;
    sTable_[4'hA] = 4'hF;
    sTable_[4'hB] = 4'h7;
    sTable_[4'hC] = 4'h4;
    sTable_[4'hD] = 4'hA;
    sTable_[4'hE] = 4'h1;
    sTable_[4'hF] = 4'h2;
  end

  initial begin
    $dumpfile("work/wave.ocd");
    $dumpvars(0, test_bench_xps);
  end

  initial begin
    for (int i = 0; i < 256; i++) begin
      {data_, key_} = i;
      #1;
      // Табличная подстановка S и математическая перестановка P.
      expectedCipherText_ = {sTable_[data_][2:0], sTable_[data_][3]} ^ key_;
      assert (cipherText_ == expectedCipherText_)
      else
        $error(
            $sformatf(
                "Wrong result_ for data_ = %h, key_ = %h: expected - %h, rtl - %h",
                data_,
                key_,
                expectedCipherText_,
                cipherText_
            )
        );
    end

    $display("All 256 S-box and permutation tests passed.");
    $finish;
  end

  XPSComposition dut (
      .data_(data_),
      .key_(key_),
      .cipherText_(cipherText_)
  );

endmodule
