import UIKit

final class ContactListTableViewController: UITableViewController {
  // MARK: - Properties
  private let cellIdentifier = "ContactCell"
    @IBOutlet var contactPreviewView: ContactPreviewView!
    
    private var contacts: [Contact] = [
    Contact(name: "John Doe", photo: "rw-logo"),
    Contact(name: "Jane Doe", photo: "rw-logo"),
    Contact(name: "Joseph Doe", photo: "rw-logo")]
    
    
  // MARK: - Life Cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.rowHeight = 44
    configureGestures()
  }
  
  // MARK: - UITableViewDataSource
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contacts.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
      as? ContactTableViewCell else { fatalError("Dequeued unregistered cell.") }
    
    let contact = contacts[indexPath.row]
    cell.nameLabel.text = contact.name
    
    return cell
  }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let contact = contacts[indexPath.row]
        
        contactPreviewView.nameLabel.text = contact.name
        contactPreviewView.photoImageView.image =
          UIImage(named: contact.photo)
        
        contactPreviewView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(contactPreviewView)
        
        NSLayoutConstraint.activate([
            contactPreviewView.widthAnchor.constraint(
              equalToConstant: 150),
            contactPreviewView.heightAnchor.constraint(
              equalToConstant: 150),
            contactPreviewView.centerXAnchor.constraint(
              equalTo: view.centerXAnchor),
            contactPreviewView.centerYAnchor.constraint(
              equalTo: view.centerYAnchor)
          ])
        
        contactPreviewView.transform =
            CGAffineTransform(scaleX: 1.25, y: 1.25)
          contactPreviewView.alpha = 0

        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.contactPreviewView.alpha = 1
            self.contactPreviewView.transform =
                CGAffineTransform.identity
          }
    }
    
    @objc private func hideContactPreview() {
      // 1
      UIView.animate(withDuration: 0.3, animations: { [weak self] in
        guard let self = self else { return }
        self.contactPreviewView.transform =
          CGAffineTransform(scaleX: 1.25, y: 1.25)
        self.contactPreviewView.alpha = 0
      }) { (success) in
        // 2
        self.contactPreviewView.removeFromSuperview()
      }
    }
    
    private func configureGestures() {
      // 1
      let tapGesture = UITapGestureRecognizer(
        target: self,
        action: #selector(hideContactPreview))
      // 2
      contactPreviewView.addGestureRecognizer(tapGesture)
      view.addGestureRecognizer(tapGesture)
    }
}
