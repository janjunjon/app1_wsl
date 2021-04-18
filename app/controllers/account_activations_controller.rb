class AccountActivationsController < ApplicationController
    before_create :create_activation_digest

    def edit
    end

    private
        def create_activation_digest
        end
end
