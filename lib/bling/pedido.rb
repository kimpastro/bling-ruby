require 'httparty'

#
# Pedido: Mantém pedidos

module Bling
  class Pedido
    include HTTParty

    base_uri "#{API_URL}"

    class << self

      # Busca por um pedido
      #
      # Parâmetros:
      #
      # xml - Path para XML

      def pedido(attributes = {})
        numero = attributes[:numero].to_s

        full_data = self.send(:get, "/pedido/#{numero}/json", { query: { apikey: Bling.apikey } } )
        full_data["retorno"]["pedidos"]
      end

      # Lista pedidos do sistema
      #
      # Parâmetros:
      #
      # page - parâmetro para paginação (opcional)

      def pedidos(attributes = {})
        page_number = attributes[:page]
        page = "/page=#{page_number}" if page_number

        full_data = self.send(:get, "/pedidos#{page}/json", { query: { apikey: Bling.apikey } } )
        full_data["retorno"]["pedidos"]
      end

      # Salva um pedido
      #
      # Parâmetros:
      #
      # xml - Path para XML
      #
      # gera_nfe - true/false (opcional)

      def salvar_pedido(attributes = {})
        xml = attributes[:xml]
        gerar_nfe = attributes[:gerar_nfe].to_s

        full_data = self.send(:post, "/pedido/json", { query: { apikey: Bling.apikey, xml: xml, gerarnfe: gerar_nfe } } )
        full_data["retorno"]["pedidos"]
      end
    end
  end
end

