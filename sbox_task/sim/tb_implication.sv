`timescale 1ns / 1ns

module tb_implication;
  logic [3:0] data_;
  logic [3:0] key_;
  logic [3:0] cipherText_;
  logic [3:0] pSTable_[0:15];
  integer errors;

  initial begin
    pSTable_[0] = 4'hC;
    pSTable_[1] = 4'h8;
    pSTable_[2] = 4'h9;
    pSTable_[3] = 4'hA;
    pSTable_[4] = 4'h0;
    pSTable_[5] = 4'hE;
    pSTable_[6] = 4'h4;
    pSTable_[7] = 4'hD;
    pSTable_[8] = 4'h2;
    pSTable_[9] = 4'hF;
    pSTable_[10] = 4'h7;
    pSTable_[11] = 4'h1;
    pSTable_[12] = 4'h6;
    pSTable_[13] = 4'h5;
    pSTable_[14] = 4'h3;
    pSTable_[15] = 4'hB;
    errors = 0;

    $dumpfile("work/xps_composition.vcd");
    $dumpvars(0, tb_implication);

    for (int i = 0; i < 16; i++) begin
      for (int j = 0; j < 16; j++) begin
        data_ = i[3:0];
        key_  = j[3:0];
        #1;
        if (cipherText_ !== (pSTable_[i] ^ j[3:0])) begin
          errors++;
          $error("data_=%h key_=%h: expected=%h, got=%h", data_, key_, pSTable_[i] ^ j[3:0],
                 cipherText_);
        end
      end
    end

    if (errors == 0) begin
      $display("PASS: checked all 256 data_/key_ combinations");
    end else begin
      $fatal(1, "FAIL: %0d errors", errors);
    end
    $finish;
  end

  XPSComposition dut (
      .data_(data_),
      .key_(key_),
      .cipherText_(cipherText_)
  );

endmodule
