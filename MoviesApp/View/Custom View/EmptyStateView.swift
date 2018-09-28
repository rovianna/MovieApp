//
//  EmptyStateView.swift
//  MoviesApp
//
//  Created by Rodrigo Vianna on 28/09/18.
//  Copyright © 2018 Rodrigo Vianna. All rights reserved.
//

protocol EmptyStateViewDelegate {
    func emptyStateView(_ emptyStateView: EmptyStateView, didTap refreshAction: UIButton)
}

import UIKit

class EmptyStateView: UIView {
    class var instance: EmptyStateView {
        let nib = UINib(nibName: "EmptyStateView", bundle: nil)
        let view = nib.instantiate(withOwner: nil, options: nil).first as! EmptyStateView
        
        return view
    }
    
    var delegate: EmptyStateViewDelegate?
    
    @IBOutlet weak var errorDescriptionLabel: UILabel!
    
    @IBAction func retryAction(_ sender: UIButton) {
        delegate?.emptyStateView(self, didTap: sender)
    }
    
    func configureView(error: State) {
        switch error {
        case .empty:
            errorDescriptionLabel.text = "Nenhum filme foi encontrado :("
        default:
            errorDescriptionLabel.text = "Oh não! Houve um erro ao buscar seus filmes :("
        }
    }
    
}
