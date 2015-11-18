module ResourceBoardHelper
  def get_folder_tree folder, blacklist, is_root = true
    tree = []
    folder.children.each do |child|
      next if blacklist.include? child
      node = { text: child.name, icon: 'fa fa-folder-o', id: child.id }
      node[:children] = get_folder_tree(child, blacklist, false) if not child.children.empty?
      tree << node
    end
    if is_root
      if tree.empty?
        tree = { text: '/', icon: 'fa fa-folder-o', id: folder.id }
      else
        tree = { text: '/', icon: 'fa fa-folder-o', id: folder.id, children: tree }
      end
    end
    tree
  end

  def get_resource_icon object
    case object
    when Resource
      fa_icon('file-o')
    when Folder
      fa_icon('folder-o')
    end
  end
end
