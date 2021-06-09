//
//  ViewController.swift
//  AudioPlayer
//
//  Created by 현은백 on 2021/05/16.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let table = UITableView(frame: .zero)
    var songs = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSongs()
        table.delegate = self
        table.dataSource = self
        table.register(TableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    func configureSongs() {
        songs.append(Song(name: "Background Music",
                          albumName: "Undefined",
                          artistName: "No one",
                          imageName: "d",
                          trackName: "cutthroat"))
        songs.append(Song(name: "Havana",
                          albumName: "Havana album",
                          artistName: "Camilla Cabello",
                          imageName: "b",
                          trackName: "havana"))
        songs.append(Song(name: "Viva La vida",
                          albumName: "123 blah",
                          artistName: "Coldplay",
                          imageName: "c",
                          trackName: "vivalavida"))
        songs.append(Song(name: "Background Music",
                          albumName: "Undefined",
                          artistName: "No one",
                          imageName: "d",
                          trackName: "cutthroat"))
        songs.append(Song(name: "Havana",
                          albumName: "Havana album",
                          artistName: "Camilla Cabello",
                          imageName: "b",
                          trackName: "havana"))
        songs.append(Song(name: "Viva La vida",
                          albumName: "123 blah",
                          artistName: "Coldplay",
                          imageName: "c",
                          trackName: "vivalavida"))

        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let song = songs[indexPath.row]
        //configure
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.albumName
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(named: song.imageName)
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: 17)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //present the player
        let position = indexPath.row
        //songs
        let vc = Player()
        vc.songs = songs
        vc.position = position
        
        present(vc, animated: true, completion: nil)
    }


}

struct Song {
    let name: String
    let albumName: String
    let artistName: String
    let imageName: String
    let trackName: String
}
