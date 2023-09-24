from typing import List

import numpy as np
from gensim.models.word2vec import Word2Vec


def vectorizer(
    corpus: List[List[str]], model: Word2Vec, num_features: int = 100
) -> np.ndarray:
    """
    This function takes a list of tokenized text documents (corpus) and a pre-trained
    Word2Vec model as input, and returns a matrix where each row represents the
    vectorized form of a document.

    Args:
        corpus : list
            A list of text documents that needs to be vectorized.

        model : Word2Vec
            A pre-trained Word2Vec model that will be used to vectorize the corpus.

        num_features : int
            The size of the vector representation of each word. Default is 100.

    Returns:
        corpus_vectors : numpy.ndarray
            A 2D numpy array where each row represents the vectorized form of a
            document in the corpus.
    """
        # Initialize an empty matrix to store document vectors
    corpus_vectors = np.zeros((len(corpus), num_features), dtype="float32")

    for i, tokens in enumerate(corpus):
        # Initialize a count and an empty vector
        vector = np.zeros(num_features, dtype="float32")
        count = 0

        # Iterate over words in the document and add their vectors
        for word in tokens:
            if word in model.wv:
                vector += model.wv[word]
                count += 1
        
        # Normalize the vector by dividing it by the count
        if count > 0:
            vector /= count

        corpus_vectors[i] = vector

    return corpus_vectors
