

import UIKit

class PresentationController: UIPresentationController {
    
    // MARK: - Properties
    private var dimmingView: UIView!
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var frame: CGRect = .zero
        frame.size = CGSize(width: 300, height: 400)
        frame.origin = CGPoint(x: UIScreen.main.bounds.size.width/2-300/2, y: UIScreen.main.bounds.size.height/2-400/2)
        return frame
    }
    
    // MARK: - Initializers
    override init(presentedViewController: UIViewController,
         presenting presentingViewController: UIViewController?) {
      super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        setupDimmingView()
    }

    override func presentationTransitionWillBegin() {
      guard let dimmingView = dimmingView else {
        return
      }
      containerView?.insertSubview(dimmingView, at: 0)

      NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimmingView]|",
                                                                 options: [],
                                                                 metrics: nil,
                                                                 views: ["dimmingView": dimmingView]))

      NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimmingView]|",
                                                                 options: [],
                                                                 metrics: nil,
                                                                 views: ["dimmingView": dimmingView]))

      guard let coordinator = presentedViewController.transitionCoordinator else {
        dimmingView.alpha = 1.0
        return
      }

      coordinator.animate(alongsideTransition: { _ in
        self.dimmingView.alpha = 1.0
      })
    }

    override func dismissalTransitionWillBegin() {
      guard let coordinator = presentedViewController.transitionCoordinator else {
        dimmingView.alpha = 0.0
        return
      }

      coordinator.animate(alongsideTransition: { _ in
        self.dimmingView.alpha = 0.0
      })
    }
    
    override func containerViewWillLayoutSubviews() {
      presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func size(forChildContentContainer container: UIContentContainer,
                       withParentContainerSize parentSize: CGSize) -> CGSize {
          return CGSize(width: parentSize.width, height: parentSize.height)
    }
}

// MARK: - Private
private extension PresentationController {
  func setupDimmingView() {
    dimmingView = UIView()
    dimmingView.translatesAutoresizingMaskIntoConstraints = false
    dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
    dimmingView.alpha = 0.0

//    let recognizer = UITapGestureRecognizer(target: self,
//                                            action: #selector(handleTap(recognizer:)))
//    dimmingView.addGestureRecognizer(recognizer)
  }

//  @objc func handleTap(recognizer: UITapGestureRecognizer) {
//    presentingViewController.dismiss(animated: true)
//  }
}

