`timescale 1ns / 1ns

module test_bench_xps;
  logic [3:0] data_;
  logic [3:0] key_;
  logic [3:0] cipherText_;
  logic [3:0] cipherTextRef_;
  logic [3:0] sTable_[0:15];
  logic [3:0] pTable_[0:15];

  initial begin
    $dumpfile("work/wave.ocd");
    $dumpvars(0, test_bench_xps);

    sTable_[0] = 4'hE;
    sTable_[1] = 4'hC;
    sTable_[2] = 4'h6;
    sTable_[3] = 4'hB;
    sTable_[4] = 4'h9;
    sTable_[5] = 4'h0;
    sTable_[6] = 4'h8;
    sTable_[7] = 4'hD;
    sTable_[8] = 4'h3;
    sTable_[9] = 4'h5;
    sTable_[10] = 4'hF;
    sTable_[11] = 4'h7;
    sTable_[12] = 4'h4;
    sTable_[13] = 4'hA;
    sTable_[14] = 4'h1;
    sTable_[15] = 4'h2;

    pTable_[0] = 4'h0;
    pTable_[1] = 4'h2;
    pTable_[2] = 4'h4;
    pTable_[3] = 4'h6;
    pTable_[4] = 4'h8;
    pTable_[5] = 4'hA;
    pTable_[6] = 4'hC;
    pTable_[7] = 4'hE;
    pTable_[8] = 4'h1;
    pTable_[9] = 4'h3;
    pTable_[10] = 4'h5;
    pTable_[11] = 4'h7;
    pTable_[12] = 4'h9;
    pTable_[13] = 4'hB;
    pTable_[14] = 4'hD;
    pTable_[15] = 4'hF;

    for (int i = 0; i < 16; i++) begin
      for (int j = 0; j < 16; j++) begin
        data_ = i[3:0];
        key_ = j[3:0];
        cipherTextRef_ = pTable_[sTable_[data_]] ^ key_;
        #10;

        $display(
            "data = %h, key = %h, S(data) = %h, P(S(data)) = %h, cipherText = %h, expected = %h",
            data_,
            key_,
            sTable_[data_],
            pTable_[sTable_[data_]],
            cipherText_,
            cipherTextRef_
        );

        assert (cipherText_ == cipherTextRef_)
          else $error(
              "Wrong result for data = %h, key = %h: expected = %h, actual = %h",
              data_,
              key_,
              cipherTextRef_,
              cipherText_
          );
      end
    end

    $finish;
  end

  XPSComposition dut (
      .data_(data_),
      .key_(key_),
      .cipherText_(cipherText_)
  );
endmodule
