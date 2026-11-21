/// @file XPSComposition.sv
/// @brief Модуль, реализующий композицию отображений XPS.
///

/// @param[in] data_ Входные данные (4 бита).
/// @param[in] key_ Ключ (4 бита).
/// @param[out] cipherText_ Результат преобразования XPS (4 бита).
module XPSComposition (
    input  logic [3:0] data_,
    input  logic [3:0] key_,
    output logic [3:0] cipherText_
);
  logic [3:0] sBlock;

  always @(*) begin
    case (data_)
      4'h0: sBlock = 4'hE;
      4'h1: sBlock = 4'hC;
      4'h2: sBlock = 4'h6;
      4'h3: sBlock = 4'hB;
      4'h4: sBlock = 4'h9;
      4'h5: sBlock = 4'h0;
      4'h6: sBlock = 4'h8;
      4'h7: sBlock = 4'hD;
      4'h8: sBlock = 4'h3;
      4'h9: sBlock = 4'h5;
      4'hA: sBlock = 4'hF;
      4'hB: sBlock = 4'h7;
      4'hC: sBlock = 4'h4;
      4'hD: sBlock = 4'hA;
      4'hE: sBlock = 4'h1;
      4'hF: sBlock = 4'h2;
    endcase
  end

  logic [3:0] pBlock;

  assign pBlock = {sBlock[2:0], sBlock[3]};

  assign cipherText_ = pBlock ^ key_;
endmodule
