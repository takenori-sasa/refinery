module Refinery
  module Members
    module Admin
      class MembersController < ::Refinery::AdminController

        crudify :'refinery/members/member',
                :title_attribute => 'name'

        private

        # Only allow a trusted parameter "white list" through.
        def member_params
          params.require(:member).permit(:name, :romanized_name, :photo_id, :university, :occupation, :blurb)
        end
      end
    end
  end
end
