# -*- coding: utf-8 -*-
# =Android

module Jpmobile::Mobile
  # ==Android
  class Android < SmartPhone
    # 対応するUser-Agentの正規表現
    USER_AGENT_REGEXP = /Android/

    # Jpmobile::Rack::Filter を適用する
    def apply_filter?
      true
    end

    # Jpmobile::Rack::ParamsFilter を適用する
    def apply_params_filter?
      true
    end

    # 文字コード変換
    def to_internal(str)
      # 絵文字を数値参照に変換
      str = Jpmobile::Emoticon.external_to_unicodecr_softbank(Jpmobile::Util.utf8(str))
      # 数値参照を UTF-8 に変換
      Jpmobile::Emoticon.unicodecr_to_utf8(str)
    end
    def to_external(str, content_type, charset)
      # UTF-8を数値参照に
      str = Jpmobile::Emoticon.utf8_to_unicodecr(str)
      # 数値参照を絵文字コードに変換
      str = Jpmobile::Emoticon.unicodecr_to_external(str, Jpmobile::Emoticon::CONVERSION_TABLE_TO_SOFTBANK, false)

      [str, charset]
    end
  end
end
