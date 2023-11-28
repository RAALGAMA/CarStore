ActiveAdmin.register About do

  permit_params :content

  form do |f|
    f.inputs "About Details" do
      f.input :content, as: :ckeditor
    end
    f.actions
  end

end
