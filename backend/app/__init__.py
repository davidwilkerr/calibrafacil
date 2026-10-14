from flask import Flask, jsonify

def create_app():
    # Cria a instância principal do Flask
    app = Flask(__name__)

    # Registra a rota de verificação de saúde da API
    @app.route('/api/v1/health', methods=['GET'])
    def health_check():
        return jsonify(status="ok")

    return app