//
//  Movie.swift
//  Notification Example
//
//  Created by Vilar da Camara Neto on 13/11/18.
//  Copyright © 2018 Vilar da Camara Neto. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit


class Movie {
    enum Genre: Int {
        case action = 0
        case adventure = 1
        case animation = 2
        case biography = 3
        case comedy = 4
        case drama = 5
        case fantasy = 6
        case romance = 7
        case short = 8

        private static let allNames: [Movie.Genre: String] = [
            .action: "Ação",
            .adventure: "Aventura",
            .animation: "Animação",
            .biography: "Biografia",
            .comedy: "Comédia",
            .drama: "Drama",
            .fantasy: "Fantasia",
            .romance: "Romance",
            .short: "Curta-metragem",
        ]

        static let count: Int = {
            return Movie.Genre.allNames.count
        }()

        var name: String {
            return Movie.Genre.allNames[self]!
        }
    }

    static let placeholderImage: UIImage = {
        return UIImage(named: "PlaceholderMovie")!
    }()
    static let defaultSize: CGSize = {
        return Movie.placeholderImage.size
    }()
    private static let imageDownloadSession = URLSession(configuration: URLSessionConfiguration.default)

    var title: String
    var portugueseTitle: String?
    var genre: Genre?
    var duration: Int?
    var year: Int?
    var isFavorite: Bool
    var imdbImageHash: String?

    private var cachedImage: UIImage? = nil
    var image: UIImage {
        if let cachedImage = cachedImage {
            return cachedImage
        }

        cachedImage = Movie.placeholderImage
        fetchImage()
        return cachedImage!
    }

    init(title: String, portugueseTitle: String? = nil, genre: Genre? = nil, duration: Int? = nil, year: Int? = nil, isFavorite: Bool = false, imdbImageHash: String? = nil) {
        self.title = title
        self.portugueseTitle = portugueseTitle
        self.genre = genre
        self.duration = duration
        self.year = year
        self.isFavorite = isFavorite
        self.imdbImageHash = imdbImageHash
    }

    func getUrl(forSize unscaledSize: CGSize) -> URL? {
        guard let imdbImageHash = imdbImageHash, let hashInitial = imdbImageHash.first else {
            return nil
        }

        let size = CGSize(width: unscaledSize.width * UIScreen.main.scale, height: unscaledSize.height * UIScreen.main.scale)

        return URL(string: "https://m.media-amazon.com/images/\(hashInitial)/\(imdbImageHash)@@._V1_UX\(size.width)_CR0,0,\(size.width),\(size.height)_AL_.jpg")
    }

    private func fetchImage() {
        guard let url = getUrl(forSize: Movie.defaultSize) else {
            return
        }

        let task = Movie.imageDownloadSession.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            guard let data = data, error == nil else {
                return
            }
            self.cachedImage = UIImage(data: data, scale: UIScreen.main.scale)
        }

        task.resume()
    }
}


var allMovies: [Movie] = [
    Movie(title: "A Dangerous Method", portugueseTitle: "Um Método Perigoso", genre: .biography, duration: 5940, year: 2011, imdbImageHash: "MV5BMTU5Mjk3NjgxMl5BMl5BanBnXkFtZTcwMDM5MjA5Ng"),
    Movie(title: "Over Her Dead Body", portugueseTitle: "Nem por Cima do Meu Cadáver", genre: .comedy, duration: 5700, year: 2008),
    Movie(title: "Across the Universe", genre: .drama, duration: 7980, year: 2007, isFavorite: true, imdbImageHash: "MV5BMTIyMTUwNzg3Nl5BMl5BanBnXkFtZTcwMjM1MDI1MQ"),
    Movie(title: "I Love You Phillip Morris", portugueseTitle: "O Golpista do Ano", genre: .biography, duration: 6120, year: 2009),
    Movie(title: "Remember Me", portugueseTitle: "Viva - A Vida é uma Festa", genre: .animation, year: 2017),
    Movie(title: "Valentine's Day", portugueseTitle: "Idas e Vindas do Amor", genre: .comedy, duration: 7500, year: 2010),
    Movie(title: "The Heartbreak Kid", portugueseTitle: "Antes Só do que Mal Casado", genre: .comedy, duration: 6960, year: 2007),
    Movie(title: "Youth in Revolt", portugueseTitle: "Rebelde com Causa", genre: .comedy, duration: 5400, year: 2009),
    Movie(title: "Zack and Miri Make a Porno", portugueseTitle: "Pagando Bem, que Mal Tem?", genre: .comedy, duration: 6060, year: 2008),
    Movie(title: "It's Complicated", portugueseTitle: "Simplesmente Complicado", genre: .comedy, year: 2009),
    Movie(title: "The Time Traveler's Wife", portugueseTitle: "Te Amarei Para Sempre", genre: .drama, duration: 6420, year: 2009),
    Movie(title: "Water for Elephants", portugueseTitle: "Água para Elefantes", genre: .drama, year: 2011),
    Movie(title: "The Ugly Truth", portugueseTitle: "A Verdade Nua e Crua", genre: .comedy, duration: 5760, year: 2009),
    Movie(title: "The Duchess", portugueseTitle: "A Duquesa", genre: .biography, duration: 6600, year: 2008),
    Movie(title: "New Year's Eve", portugueseTitle: "Noite de Ano Novo", genre: .comedy, duration: 6780, year: 2011),
    Movie(title: "Life as We Know It", portugueseTitle: "Juntos Pelo Acaso", genre: .comedy, year: 2010),
    Movie(title: "Miss Pettigrew Lives for a Day", portugueseTitle: "A Vida num Só Dia", genre: .comedy, duration: 5520, year: 2008),
    Movie(title: "A Serious Man", portugueseTitle: "Um Homem Sério", genre: .comedy, duration: 6360, year: 2009),
    Movie(title: "P.S. I Love You", portugueseTitle: "P.S. Eu te Amo", genre: .drama, duration: 7560, year: 2007),
    Movie(title: "High School Musical 3: Senior Year", portugueseTitle: "High School Musical 3: Ano da Formatura", genre: .comedy, duration: 6720, year: 2008),
    Movie(title: "Waitress", portugueseTitle: "Garçonete", genre: .comedy, duration: 6480, year: 2007),
    Movie(title: "When in Rome - Fünf Männer sind vier zuviel", portugueseTitle: "Quando em Roma", genre: .comedy, duration: 5460, year: 2010),
    Movie(title: "The Back-up Plan", portugueseTitle: "Plano B", genre: .comedy, duration: 6240, year: 2010),
    Movie(title: "What Happens in Vegas", portugueseTitle: "Jogo de Amor em Las Vegas", genre: .comedy, duration: 5940, year: 2008),
    Movie(title: "Waiting for Forever", portugueseTitle: "Esperar para Sempre", genre: .comedy, year: 2010),
    Movie(title: "Good Luck Chuck", portugueseTitle: "Maldita Sorte", genre: .comedy, duration: 6060, year: 2007),
    Movie(title: "Knocked Up", portugueseTitle: "Ligeiramente Grávidos", genre: .comedy, duration: 7740, year: 2007),
    Movie(title: "Enchanted", portugueseTitle: "Encantada", genre: .animation, duration: 6420, year: 2007),
    Movie(title: "He's Just Not That Into You", portugueseTitle: "Ele Não Está Tão a Fim de Você", genre: .comedy, duration: 7740, year: 2009),
    Movie(title: "Sex and the City", genre: .comedy, duration: 1800, year: 1998),
    Movie(title: "Letters to Juliet", portugueseTitle: "Cartas para Julieta", genre: .adventure, year: 2010),
    Movie(title: "Just Wright - In diesem Spiel zählt jeder Treffer", portugueseTitle: "Jogada Certa", genre: .comedy, year: 2010),
    Movie(title: "Mamma Mia! O Filme", genre: .comedy, duration: 6480, year: 2008),
    Movie(title: "Marley and Me", portugueseTitle: "Marley & Eu", genre: .comedy, year: 2008),
    Movie(title: "Tangled", portugueseTitle: "Enrolados", genre: .animation, duration: 6000, year: 2010),
    Movie(title: "She's Out of My League", portugueseTitle: "Ela é Demais Pra Mim", genre: .comedy, year: 2010),
    Movie(title: "Going the Distance", portugueseTitle: "Amor à Distância", genre: .comedy, year: 2010),
    Movie(title: "Penelope", genre: .comedy, duration: 6240, year: 2006),
    Movie(title: "(500) Days of Summer", portugueseTitle: "(500) Dias com Ela", genre: .comedy, duration: 5700, year: 2009, imdbImageHash: "MV5BMTk5MjM4OTU1OV5BMl5BanBnXkFtZTcwODkzNDIzMw"),
    Movie(title: "Love Happens", portugueseTitle: "O Amor Acontece", genre: .drama, year: 2009),
    Movie(title: "No Reservations", portugueseTitle: "Sem Reservas", genre: .comedy, duration: 6240, year: 2007),
    Movie(title: "Leap Year", portugueseTitle: "Casa Comigo?", genre: .comedy, year: 2010),
    Movie(title: "The Proposal", portugueseTitle: "A Proposta", genre: .comedy, duration: 6480, year: 2009),
    Movie(title: "Four Christmases", portugueseTitle: "Surpresas do Amor", genre: .comedy, duration: 5280, year: 2008),
    Movie(title: "Beginners, así se siente el amor", portugueseTitle: "Toda Forma de Amor", genre: .comedy, duration: 6300, year: 2010),
    Movie(title: "One Day (Siempre el mismo día)", portugueseTitle: "Um Dia", genre: .drama, duration: 6420, year: 2011),
    Movie(title: "La saga Twilight: La fascination", portugueseTitle: "Crepúsculo", genre: .drama, duration: 7320, year: 2008),
    Movie(title: "Twilight: Breaking Dawn Part 1: The PSA Part 1", genre: .short, year: 2012),
    Movie(title: "The Invention of Lying", portugueseTitle: "O Primeiro Mentiroso", genre: .comedy, duration: 6000, year: 2009),
    Movie(title: "Gnomeo and Juliet", genre: .animation, year: 2011),
    Movie(title: "Dear John", portugueseTitle: "Querido John", genre: .drama, duration: 6480, year: 2010),
    Movie(title: "Love & Other Drugs", portugueseTitle: "Amor e Outras Drogas", genre: .comedy, duration: 6720, year: 2010),
    Movie(title: "Wall-E", portugueseTitle: "WALL·E", genre: .animation, duration: 5880, year: 2008, isFavorite: true, imdbImageHash: "MV5BMjExMTg5OTU0NF5BMl5BanBnXkFtZTcwMjMxMzMzMw"),
    Movie(title: "Jane Eyre", genre: .drama, duration: 7200, year: 2011),
    Movie(title: "The Twilight Saga: New Moon", portugueseTitle: "A Saga Crepúsculo: Lua Nova", genre: .adventure, duration: 7800, year: 2009),
    Movie(title: "Our Family Wedding", portugueseTitle: "Nossa União, Muita Confusão", genre: .comedy, year: 2010),
    Movie(title: "27 Dresses", portugueseTitle: "Vestida para Casar", genre: .comedy, duration: 6660, year: 2008, imdbImageHash: "MV5BMzI5OTM0OTg2MF5BMl5BanBnXkFtZTcwNjAyMTU1MQ"),
    Movie(title: "Midnight in Paris", portugueseTitle: "Meia-Noite em Paris", genre: .comedy, year: 2011),
    Movie(title: "Ghosts of Girlfriends Past", portugueseTitle: "Minhas Adoráveis Ex-Namoradas", genre: .comedy, year: 2009),
    Movie(title: "Killers", portugueseTitle: "Par Perfeito", genre: .action, duration: 6000, year: 2010),
    Movie(title: "Sex and the City 2", genre: .comedy, duration: 8760, year: 2010),
    Movie(title: "Music and Lyrics", portugueseTitle: "Letra e Música", genre: .comedy, duration: 5700, year: 2007),
    Movie(title: "Tyler Perry's Why Did I Get Married?", portugueseTitle: "Por Que Eu Me Casei?", genre: .comedy, year: 2007),
    Movie(title: "Not Easily Broken", portugueseTitle: "Ponto de Decisão", genre: .drama, duration: 5940, year: 2009),
    Movie(title: "The Curious Case of Benjamin Button", portugueseTitle: "O Curioso Caso de Benjamin Button", genre: .drama, duration: 9960, year: 2008, isFavorite: true),
    Movie(title: "Fireproof", portugueseTitle: "À Prova de Fogo", genre: .drama, year: 2008),
    Movie(title: "Made of Honor", portugueseTitle: "O Melhor Amigo da Noiva", genre: .comedy, duration: 6060, year: 2008),
    Movie(title: "You Will Meet a Tall Dark Stranger", portugueseTitle: "Você Vai Conhecer o Homem dos Seus Sonhos", genre: .comedy, year: 2010),
    Movie(title: "Nick and Norah's Infinite Playlist", portugueseTitle: "Nick & Norah: Uma Noite de Amor e Música", genre: .comedy, duration: 5400, year: 2008),
    Movie(title: "Monte Carlo", genre: .adventure, year: 2011),
    Movie(title: "Something Borrowed", portugueseTitle: "Muito Bem Acompanhada", genre: .comedy, duration: 5400, year: 2005),
    Movie(title: "My Week with Marilyn", portugueseTitle: "Sete Dias com Marilyn", genre: .biography, duration: 5940, year: 2011),
    Movie(title: "Rachel Getting Married", portugueseTitle: "O Casamento de Rachel", genre: .drama, duration: 6780, year: 2008),
    Movie(title: "License to Wed", portugueseTitle: "Licença para Casar", genre: .comedy, duration: 5460, year: 2007),
    ].sorted { (lhs: Movie, rhs: Movie) -> Bool in
        return lhs.title.caseInsensitiveCompare(rhs.title) == .orderedAscending
}
