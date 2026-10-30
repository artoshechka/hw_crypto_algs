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

  /// Таблица подстановки S-box.
  logic [3:0] S[0:15];

  assign S[0]  = 4'h6;
  assign S[1]  = 4'h4;
  assign S[2]  = 4'hC;
  assign S[3]  = 4'h5;
  assign S[4]  = 4'h0;
  assign S[5]  = 4'h7;
  assign S[6]  = 4'h2;
  assign S[7]  = 4'hE;
  assign S[8]  = 4'h1;
  assign S[9]  = 4'hF;
  assign S[10] = 4'hB;
  assign S[11] = 4'h8;
  assign S[12] = 4'h3;
  assign S[13] = 4'hA;
  assign S[14] = 4'h9;
  assign S[15] = 4'hD;

  logic [3:0] compositionResult_;  /// Результат композиции P(S(data_)).
  logic [3:0] sBoxValue_;  /// Промежуточное значение после применения S-box.

  always @(*) begin
    sBoxValue_ = S[data_];
    compositionResult_ = {sBoxValue_[2:0], sBoxValue_[3]};
    cipherText_ = compositionResult_ ^ key_;
  end

endmodule
