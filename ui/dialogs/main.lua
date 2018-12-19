require("mod-gui")
require("ui.util")
require("titlebar")
require("actionbar")
require("subfactory_bar")


-- Create the always-present GUI button to open the main dialog
function gui_init(player)
    local frame_flow = mod_gui.get_frame_flow(player)
    if not frame_flow["fp_button_toggle_interface"] then
        frame_flow.add
        {
            type = "button",
            name = "fp_button_toggle_interface",
            caption = "FP",
            tooltip = {"tooltip.open_main_dialog"},
            style = mod_gui.button_style
        }
    end
    -- Temporary for dev puroposes
    if not global["subfactories"][1] then global["subfactories"][1] = {name=nil, icon="iron-plate"} end
    if not global["subfactories"][2] then global["subfactories"][2] = {name="Beta", icon="copper-plate"} end
    if not global["subfactories"][3] then global["subfactories"][3] = {name="Delta", icon=nil} end
end


-- Toggles the main dialog open and closed
function toggle_main_dialog(player)
    -- Won't toggle if a modal dialog is open
    if not global["modal_dialog_open"] then
        local main_dialog = player.gui.center["main_dialog"]
        if main_dialog == nil then
            create_main_dialog(player)
        elseif main_dialog.style.visible == false then
            if global["devmode"] then
                create_main_dialog(player)
            else
                main_dialog.style.visible = true
            end
        else
            if global["devmode"] then
                main_dialog.destroy()
            else
                main_dialog.style.visible = false
            end
        end
    end
end


-- Constructs the main dialog
function create_main_dialog(player)
    local main_dialog = player.gui.center.add{type="frame", name="main_dialog", direction="vertical"}
    main_dialog.style.right_padding = 6

    add_titlebar_to(main_dialog)
    add_actionbar_to(main_dialog)
    add_subfactory_bar_to(main_dialog, player)
end