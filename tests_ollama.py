from typing import Literal
from pydantic import BaseModel
from ollama import chat

class Avis(BaseModel):
    sentiment: Literal["positif", "negatif", "neutre"]
    mentionne_prix: bool

texte = "Super produit, mais livraison hors de prix."

response = chat(
    model="llama3.1:8b",  # remplace par un nom de `ollama list`
    messages=[{"role": "user", "content": f"Analyse ce texte : {texte}"}],
    format=Avis.model_json_schema(),
    options={"temperature": 0},
)

resultat = Avis.model_validate_json(response.message.content)
print(resultat)