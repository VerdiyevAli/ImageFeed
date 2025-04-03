import UIKit

final class SingleImageViewController: UIViewController {
    var image: UIImage? {
        didSet {
            guard isViewLoaded, let image else { return }
            imageView.image = image
            imageView.frame.size = image.size
            rescaleAndCenterImageInScrollView()
        }
    }

    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        
        guard let image else { return }
        imageView.image = image
        imageView.frame.size = image.size
        rescaleAndCenterImageInScrollView()
    }

    @IBAction private func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func didTapShareButton(_ sender: UIButton) {
        guard let image else { return }
        let share = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(share, animated: true, completion: nil)
    }

    private func rescaleAndCenterImageInScrollView() {
        guard let image = image else { return }
        
        let scrollViewSize = scrollView.bounds.size
        let imageSize = image.size
        
        let hScale = scrollViewSize.width / imageSize.width
        let vScale = scrollViewSize.height / imageSize.height
        let scale = min(hScale, vScale)
        
        scrollView.minimumZoomScale = scale
        scrollView.setZoomScale(scale, animated: false)
        
        updateContentInset()
    }

    private func updateContentInset() {
        let boundsSize = scrollView.bounds.size
        let imageFrame = imageView.frame

        let horizontalInset = max((boundsSize.width - imageFrame.width) / 2, 0)
        let verticalInset = max((boundsSize.height - imageFrame.height) / 2, 0)

        scrollView.contentInset = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
    }
}

extension SingleImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateContentInset()
    }

    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        if scale <= scrollView.minimumZoomScale {
            UIView.animate(withDuration: 0.3, animations: {
                self.scrollView.setZoomScale(self.scrollView.minimumZoomScale, animated: false)
                self.updateContentInset()
            })
        }
    }
}
