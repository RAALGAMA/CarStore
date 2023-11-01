ActiveAdmin.register Horse do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :age, :top_speed, :number_of_legs, :breed_id, :image
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :age, :top_speed, :number_of_legs, :breed_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form do |f|
    f.semantic_errors
    f.inputs
    f.inputs do
      f.input :image, as: :file,
                      #hint: f.object.image.present? ? image_tag(f.object.image.variant(resize_to_limit: [500, 500])) : ''
                      hint: f.object.image.present? ? image_tag(f.object.image, size:"150x150"): ""
                    end
    f.actions
  end
end
