import UIKit

final class ImagesListViewController: UIViewController, UITableViewDelegate {
    @IBOutlet private var tableView: UITableView!

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 200
        tableView.dataSource = self
        tableView.delegate = self
        
    }
}
func configCell(for cell: ImagesListCell) {
    
}

extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath) // 1
            
            guard let imageListCell = cell as? ImagesListCell else { // 2
                return UITableViewCell()
            }
            
            configCell(for: imageListCell) // 3
            return imageListCell // 4
        }
}


